# Template example to json used as data definition

This json serves as basis to data store into vim. Its pathname and filename must be ``$MYVIM/markers/.config.json``, and it is how the dependencies must be declared besides other configurations.

<pre>{
    "env": {
        "settings": {
            "options": {
                "highlight": {
                    "Comment": {
                        "cterm": "italic"
                    }
                },
                "colorscheme": "predawn",
                "set": [
                    "encoding=utf8",
                    "nocp",
                    "wildmenu",
                    "confirm",
                    "mouse=a",
                    "title",
                    "number",
                    "autoindent",
                    "showcmd",
                    "expandtab",
                    "tabstop=4",
                    "softtabstop=4",
                    "shiftwidth=4",
                    "clipboard=unnamedplus"
                ]
            },
            "json": {
                "fixers": [
                    "fixjson"
                ]
            },
            "php": {
                "fixers": [
                    "php_cs_fixer"
                ]
            },
            "standalone-variables": {}
        },
        "plugins": {
            "coc-nvim": {
                "options": {
                    "set": [
                        "statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}"
                    ]
                },
                "variables": {
                    "g:coc_global_extensions": [
                        "coc-html",
                        "coc-sh",
                        "coc-json",
                        "coc-css",
                        "coc-pyright",
                        "coc-snippets",
                        "coc-vimlsp",
                        "coc-tsserver",
                        "@yaegassy/coc-intelephense"
                    ],
                    "g:coc_start_at_startup": 1,
                    "g:coc_snippet_next": "'<S-Right>'",
                    "g:coc_snippet_prev": "'<S-Left>'"
                }
            },
            "vim-markdown": {
                "variables": {
                    "g:vim_markdown_folding_level": 2
                }
            },
            "ctrlp": {
                "variables": {
                    "g:ctrlp_clear_cache_on_exit": 0,
                    "g:ctrlp_custom_ignore": "'\\v[\\/]\\.(git|hg|svn)$'",
                    "g:ctrlp_user_command": [
                        ".git",
                        "cd %s && git ls-files -co --exclude-standard"
                    ],
                    "g:ctrlp_cmd": "'CtrlPMRUFiles'",
                    "g:ctrlp_match_window_reversed": 0,
                    "g:ctrlp_show_hidden": 1,
                    "g:ctrlp_working_path_mode": 0
                }
            },
            "phpactor": {
                "variables": {
                    "g:phpactor_executable": "'{vi_dir}{paths:vim-plug}/phpactor/bin/phpactor'"
                },
                "swap-variables": {
                    "g:phpactor_executable": [
                        "{paths:vim-plug}"
                    ]
                }
            },
            "vim-airline": {
                "variables": {
                    "g:airline_powerline_fonts": 1,
                    "g:airline#extensions#tabline#enabled": 1,
                    "g:airline#extensions#tabline#formatter": "'unique_tail'"
                }
            },
            "vim-nerdtree-syntax-highlight": {
                "variables": {
                    "g:NERDTreeExtensionHighlightColor": {},
                    "g:WebDevIconsDefaultFolderSymbolColor": "'F5C06F'"
                }
            },
            "php_cs_fixer": {
                "variables": {
                    "g:ale_php_cs_fixer_executable": "'{vi_dir}{paths:executables}{paths:php_cs_fixer}'",
                    "g:ale_php_cs_fixer_options": "'--config={php_cs_fixer_path}.php-cs-fixer.php --allow-risky={allow-risky}'"
                },
                "install-method": "Composer",
                "swap-defaults": {
                    "g:ale_php_cs_fixer_options": {
                        "{allow-risky}": "yes",
                        "{php_cs_fixer_path}": "{vi_dir}/scripts/"
                    }
                },
                "swap-variables": {
                    "g:ale_php_cs_fixer_executable": [
                        "{paths:executables}",
                        "{paths:php_cs_fixer}"
                    ],
                    "g:ale_php_cs_fixer_options": [
                        "{php_cs_fixer_path}",
                        "{allow-risky}"
                    ]
                },
                "package-name": "friendsofphp/php-cs-fixer"
            },
            "vim-airline-themes": {
                "variables": {
                    "g:airline_theme": "'google_dark'"
                }
            },
            "emmet-vim": {
                "variables": {
                    "g:user_emmet_install_global": 0
                },
                "file-types": "html,css,php,md,markdown"
            },
            "install-methods": {
                "Composer": "composer require --dev ",
                "Npm": "npm install "
            },
            "fixjson": {
                "variables": {
                    "g:ale_json_fixjson_executable": "'{vi_dir}{paths:executables}{paths:fixjson}'",
                    "g:ale_json_fixjson_options": "'--indent 4'"
                },
                "install-method": "Npm",
                "swap-variables": {
                    "g:ale_json_fixjson_executable": [
                        "{paths:executables}",
                        "{paths:fixjson}"
                    ]
                },
                "package-name": "fixjson"
            },
            "nerdtree-git-plugin": {
                "variables": {
                    "g:NERDTreeGitStatusIndicatorMapCustom": {
                        "Untracked": "✭",
                        "Deleted": "✖",
                        "Ignored": "☒",
                        "Dirty": "✗",
                        "Modified": "✹",
                        "Renamed": "➜",
                        "Unmerged": "═",
                        "Unknown": "?",
                        "Staged": "✚",
                        "Clean": "✔︎"
                    }
                }
            },
            "nerdtree": {
                "variables": {
                    "g:NERDTreeNaturalSort": 1,
                    "g:NERDTreeDirArrowCollapsible": "'-'",
                    "g:NERDTreeDirArrowExpandable": "'+'",
                    "g:NERDTreeShowHidden": 1
                }
            },
            "nerd-fonts": {
                "script": "{vi_dir}/scripts/loadNerdfonts.sh {vi_dir} ",
                "version": "v3.003"
            },
            "ale": {
                "variables": {
                    "g:ale_fix_on_save": 1,
                    "g:ale_sign_warning": "'⚠️'",
                    "g:ale_lint_on_save": 1,
                    "g:ale_sign_error": "'☠️'",
                    "g:ale_fixers": {
                        "*": "trim_whitespace"
                    },
                    "g:ale_lint_on_enter": 0,
                    "g:ale_use_global_executables": 0
                }
            },
            "vim-devicons": {
                "variables": {
                    "g:WebDevIconsOS": "'Darwin'",
                    "g:airline_powerline_fonts": 1
                }
            }
        },
        "langs": [
            "php",
            "json"
        ]
    },
    "vim-plug": {
        "plugins": [
            [
                "preservim/nerdtree",
                "Xuyuanp/nerdtree-git-plugin",
                "ryanoasis/vim-devicons",
                "tiagofumo/vim-nerdtree-syntax-highlight"
            ],
            "mattn/emmet-vim",
            "majutsushi/tagbar",
            "dense-analysis/ale",
            "vim-airline/vim-airline",
            "vim-airline/vim-airline-themes",
            "majutsushi/tagbar",
            {
                "cfg": {
                    "branch": "release"
                },
                "pack": "neoclide/coc.nvim"
            },
            "kien/ctrlp.vim",
            "tpope/vim-surround",
            "gwww/vim-bbye",
            "rhysd/vim-healthcheck",
            "tomtom/tcomment_vim",
            "preservim/vim-markdown",
            "skywind3000/quickmenu.vim",
            {
                "cfg": {
                    "tag": "*",
                    "for": "php",
                    "do": "composer install --no-dev -o"
                },
                "pack": "phpactor/phpactor"
            }
        ]
    },
    "paths": {
        "fixjson": "/fixjson/node_modules/.bin/fixjson",
        "php_cs_fixer": "/php_cs_fixer/vendor/bin/php-cs-fixer",
        "executables": "/executables",
        "session": "/.session.vim",
        "vim-plug": "/plugged",
        "swap": "/markers/.swaps.json",
        "quickmenu": "{vi_dir}{paths:vim-plug}/quickmenu.vim/autoload/quickmenu.vim"
    },
    "running": 1,
    "bookmark": "learning"
}</pre>
