"
" Object used to manage the custom plugin installations
"
let g:PluginManager = {}

" ======================
" Constructor
" ======================
fun g:PluginManager.new()
    let l:instance = copy(self)
    return l:instance
endfu

" ======================
" Methods
" ======================

"
" Executes all initial running from this class
"
fun g:PluginManager.init(App)
    let self.App = a:App
    let self.cmd = g:App.items.Cmd
endfu

"
" Runs the fixers' definition
"
fun g:PluginManager.run_fixers(fixers, ale_fixers_item, plugin_dict)
    for fixer in a:fixers
        call add(a:ale_fixers_item, fixer)
        let l:plugin_cfg = a:plugin_dict[fixer]
        call self.run_fixer_install(fixer, l:plugin_cfg, a:plugin_dict['install-methods'])
        call self.define_variables(l:plugin_cfg)
    endfor
endfu

"
" Runs the fixer' installation (optional)
"
fun g:PluginManager.run_fixer_install(fixer, plugin_cfg, install_methods)
    if !has_key(a:plugin_cfg, 'install-method')
        return
    endif
    let l:install_method = a:plugin_cfg['install-method']
    if !has_key(a:install_methods, l:install_method)
        return
    endif
    let l:install_command = a:install_methods[l:install_method]
    call self.App.items.PluginManager.install(a:fixer, l:install_command, a:plugin_cfg['package-name'])
endfu

"
" Executes the custom and local installation from NPM to be used internally
"
" @todo Transfer data to ConfigJson (folder's name)
"
fun g:PluginManager.install(folder_name, install_command, package_name)
    let l:pathname = g:App.vi_dir . g:App.items.ConfigJson.data.paths.executables . '/' . a:folder_name
    return self.cmd.command_into_new_folder(l:pathname, a:install_command . ' ' . a:package_name)
endfu

"
" Executes the custom and local installation using a bash script
"
fun g:PluginManager.bash_install(install_command)
    let l:install_command = self.replace_vim_dir_match(a:install_command)
    silent execute '!' . l:install_command
endfu

"
" Runs the fixer' variables definition (optional)
"
fun g:PluginManager.define_variables(plugin_cfg, external_vars = v:null)
    let l:plugin_variables = self.swap_variables(get(a:plugin_cfg, 'variables', {}), a:plugin_cfg)
    for k in keys(l:plugin_variables)
        let l:val = self.replace_vim_dir(l:plugin_variables[k])
        execute 'let ' . k . ' = ' . l:val
    endfor
    if type(a:external_vars) is v:t_dict
        for k in keys(a:external_vars)
            execute 'let ' . k . ' = ' . a:external_vars[k]
        endfor
    endif
endfu

"
" Realize swaps between pathnames replaces into .config.json and a other optional json
" described in 'paths.swap' key
"
fun g:PluginManager.swap_variables(variables, plugin_cfg)
    let l:variables = copy(a:variables)
    let l:swap_base = self.App.items.ConfigJson.swap_base
    let l:swap_defaults = get(a:plugin_cfg, 'swap-defaults', {})
    let l:paths = self.App.items.ConfigJson.data.paths
    if !has_key(a:plugin_cfg, 'swap-variables')
        return l:variables
    endif
    for [variable_name, swap_items] in items(a:plugin_cfg['swap-variables'])
        for swap_key in swap_items
            if swap_key =~? '\v\{paths:.+\}'
                let l:swap_val = get(l:paths, swap_key[7:-2], '')
            else
                let l:swap_val = self.build_swap_value(l:swap_base, swap_key, l:swap_defaults, variable_name)
                if empty(l:swap_val)
                    continue
                endif
            endif
            let l:variables[variable_name] = self.replace_key(l:variables[variable_name], swap_key, l:swap_val)
        endfor
    endfor
    return l:variables
endfu

"
" Defines the possible swap values
"
fun g:PluginManager.build_swap_value(swap_base, swap_key, swap_defaults, variable_name)
    let l:swap_val = get(a:swap_base, a:swap_key, '')
    if empty(l:swap_val)
        let l:default_var = get(a:swap_defaults, a:variable_name, '')
        if !empty(l:default_var)
            let l:swap_val = get(l:default_var, a:swap_key, '')
        endif
    endif
    return l:swap_val
endfu

"
" Replaces strings that have the '{.*}' pattern
"
fun g:PluginManager.replace_key(string, key, replacer = '')
    return substitute(a:string, '\v\{' . a:key[1:-2] . '\}', a:replacer, 'g')
endfu

"
" Returns all '{.*}' patterns present into string parameter
"
fun g:PluginManager.detach_keys(string)
    let l:lst = []
    call substitute(a:string, '\v\{[^\}]*\}', '\=add(l:lst, submatch(0))', 'g')
    return l:lst
endfu

"
" Filters the variable 'val' based on its type
"
fun g:PluginManager.replace_vim_dir(val)
    if type(a:val) is v:t_list
        let l:val = map(copy(a:val), {_, item -> self.replace_vim_dir_match(item)})
        return string(l:val)
    endif
    if type(a:val) is v:t_dict
        return string(a:val)
    endif
    if type(a:val) is v:t_string
        return self.replace_vim_dir_match(a:val)
    endif
    return a:val
endfu

"
" Replaces the '{vi_dir}' pattern into path variable
"
fun g:PluginManager.replace_vim_dir_match(path)
    return substitute(a:path, '\v\{vi_dir\}', self.App.vi_dir, 'g')
endfu

call g:App.register('PluginManager', g:PluginManager.new())
