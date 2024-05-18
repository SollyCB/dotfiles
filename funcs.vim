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

