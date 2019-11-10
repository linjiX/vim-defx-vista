"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    https://github.com/linjiX/vim-defx-vista         "
"        _       __                _     _            "
"     __| | ___ / _|_  __   __   _(_)___| |_ __ _     "
"    / _` |/ _ \ |_\ \/ /___\ \ / / / __| __/ _` |    "
"   | (_| |  __/  _|>  <_____\ V /| \__ \ || (_| |    "
"    \__,_|\___|_| /_/\_\     \_/ |_|___/\__\__,_|    "
"                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:defx_vista_left = get(g:, 'defx_vista_left', 1)
let g:defx_vista_width = get(g:, 'defx_vista_width', 30)

command! -nargs=0 ToggleDefxVista :call defx_vista#ToggleDefxVista()
