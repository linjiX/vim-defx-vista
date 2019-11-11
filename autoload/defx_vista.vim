"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    https://github.com/linjiX/vim-defx-vista         "
"        _       __                _     _            "
"     __| | ___ / _|_  __   __   _(_)___| |_ __ _     "
"    / _` |/ _ \ |_\ \/ /___\ \ / / / __| __/ _` |    "
"   | (_| |  __/  _|>  <_____\ V /| \__ \ || (_| |    "
"    \__,_|\___|_| /_/\_\     \_/ |_|___/\__\__,_|    "
"                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup defx_vista
    autocmd!
augroup END

function s:HasDefx() abort
    let l:bufs = map(range(1, winnr('$')), 'winbufnr(v:val)')
    let l:bufs = filter(l:bufs, 'getbufvar(v:val, "&filetype") ==# "defx"')
    return len(l:bufs) >= 1
endfunction

function s:SetWindowConfig() abort
    if exists('g:vista_sidebar_position')
        let s:vista_sidebar_position_user = g:vista_sidebar_position
    endif
    if exists('g:vista_sidebar_width')
        let s:vista_sidebar_width_user = g:vista_sidebar_width
    endif

    if g:defx_vista_left
        let g:vista_sidebar_position = 'vertical topleft'
    else
        let g:vista_sidebar_position = 'vertical botright'
    endif
    let g:vista_sidebar_width = g:defx_vista_width
    let s:prev_winid = win_getid()
    call defx#custom#option('_', 'prev_winid', s:prev_winid)
endfunction

function s:ResetWindowConfig() abort
    if exists('s:vista_sidebar_position_user')
        let g:vista_sidebar_position = s:vista_sidebar_position_user
    else
        unlet g:vista_sidebar_position
    endif
    if exists('s:vista_sidebar_width_user')
        let g:vista_sidebar_width = s:vista_sidebar_width_user
    else
        unlet g:vista_sidebar_width
    endif

    let l:option = defx#custom#_get().option._
    unlet l:option.prev_winid

    call win_gotoid(s:prev_winid)

    unlet s:vista_sidebar_width_user
    unlet s:vista_sidebar_position_user
    unlet s:prev_winid
endfunction

function defx_vista#ToggleDefxVista() abort
    let l:has_defx = s:HasDefx()
    let l:has_vista = vista#sidebar#IsVisible()

    if l:has_defx
        Defx -toggle
    endif

    if l:has_vista
        Vista!
    endif

    if l:has_defx || l:has_vista
        return
    endif

    call s:SetWindowConfig()

    autocmd defx_vista User VistaWinOpen ++once ++nested call s:OpenDefx()
    Vista
endfunction

function s:OpenDefx() abort
    " Config for Vista
    setlocal nowinfixheight
    setlocal winfixwidth

    Defx -split='horizontal' -direction='aboveleft' -no-winwidth -no-winheight

    " Config for Defx
    setlocal nowinfixheight
    setlocal winfixwidth

    call s:ResetWindowConfig()
endfunction
