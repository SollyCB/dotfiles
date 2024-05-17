function Build(cmd)
    cgete system(a:cmd)
    if !len(getqflist())
        echo 'Build Succeeded'
    else
        echo 'Build Failed'
    endif
endfunction

function QuickCompile()
    call Build("qc " . expand("% && ./qc"))
endfunction

function BuildC()
    call Build("bash build.sh")
endfunction

function BuildGlsl()
    call Build("bash /home/solly/scripts/shader_comp.sh " . expand("%"))
endfunction

function FindTypeDeclUnderCursor()
    let l:cw = expand("<cword>")
    let l:exp = 'rg --vimgrep "} ' . cw . ';|struct ' . cw . ' \{"'
    cgete system(exp)
endfunction

function FindTypeRefsUnderCursor()
    let l:cw = expand("<cword>")
    let l:exp = 'rg --vimgrep "^ *' . cw . '[ \n]+[\w\*]|^ *struct ' . cw . '[ \n]+[\w\*]"'
    cgete system(exp)
endfunction

function FindFuncRefsUnderCursor()
    let l:cw = expand("<cword>")
    let l:exp = 'rg --vimgrep "' . cw . '[ \n]*\("'
    echo exp
    cgete system(exp)
endfunction

