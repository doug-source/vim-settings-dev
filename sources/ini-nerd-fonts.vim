" ----------------------------------------------------------------
"
"  Realiza a instalação das 'NERD fonts' (uma única vez)
"  
"  URL: https://github.com/ryanoasis/nerd-fonts
"  URL: https://docs.fedoraproject.org/en-US/quick-docs/fonts/
"
" ----------------------------------------------------------------

let s:data_dir = g:vi_dir . '/markers'

if empty(glob(s:data_dir . '/nerd-fontsOK'))
    if g:is_linux
        let s:font_url = 'https://github.com/source-foundry/Hack/releases/download'
        let s:font_version = 'v3.003'
        let s:font_basename = 'Hack-' . s:font_version' . '-ttf.zip'
        let s:font_url_tt = s:font_url . '/' . s:font_version . '/' . s:font_basename 

        let s:font_local_filename = s:data_dir .'/Hack-v3.003-ttf.zip'
        let s:down_font_cmd = 'wget -O ' . s:font_local_filename . ' ' . s:font_url_tt 
        let s:cmd_unzip_cmd = 'unzip ' . s:font_local_filename . ' -d ' . s:data_dir
        let s:font_rm_cmd = 'rm ' . s:font_local_filename

        " Realiza >>>>>
        " - o download do 'Hack package' de 'Nerd-fonts'
        " - descompacta o zip da nova font
        " - remove o zip downloaded
        let s:cmds_1 = join([s:down_font_cmd, s:cmd_unzip_cmd, s:font_rm_cmd], ' && ')

        let s:fonts_mv_cmd_1 = 'mv ' . s:data_dir . '/ttf ' . s:data_dir . '/Hack-fonts'
        let s:fonts_mv_cmd_2 = 'sudo mv ' . s:data_dir . '/Hack-fonts /usr/share/fonts/'
        " Realiza >>>>>
        " - Renomeia o arquivo unzipped para 'Hack-fonts'
        " - Move o directory da nova font para o 'font directory' do sistema
        " - (a partir daqui, erá necessário o login como superuser)
        let s:fonts_mv_cmd_tt = s:fonts_cmd_1 . ' && ' . s:fonts_cmd_2

        let s:font_perm_cmd_1 = 'sudo chown -R root: /usr/share/fonts/Hack-fonts'
        let s:font_perm_cmd_2 = 'sudo chmod 644 /usr/share/fonts/Hack-fonts/*'
        let s:font_perm_cmd_3 = 'sudo restorecon -RF /usr/share/fonts/Hack-fonts'
        " Realiza >>>>>
        " - modifica o owner do directory da nova font para 'root'
        " - modifica o mode de todas as novas fonts
        " - restaura 'SELinux security contexts'
        let s:font_perm_cmd_tt = s:font_perm_cmd_1 . ' && ' . s:font_perm_cmd_2 . ' && ' . s:font_perm_cmd_3

        " Atualiza o cache das fonts do sistema
        let s:font_rerun_cmd = 'sudo fc-cache -v'

        let s:cmds_2 = join([s:fonts_mv_cmd_tt, s:font_perm_cmd_tt, s:font_rerun_cmd], ' && ')

        " Adiciona o 'marker file' para realizar a instalação somente uma vez
        let s:marker_cmd = 'echo -e "\\nNERD-FONTS dowloaded\!\\n" > ' . s:data_dir . '/nerd-fontsOK'

        silent execute '!' . join([s:cmds_1, s:cmds_2, s:marker_cmd], ' && ')
    endif
endif
