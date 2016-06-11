execute "source ".globpath(&rtp, "test/test_helper.vim")

let g:test_suit.test.autoload = {}

function! g:test_suit.test.autoload.x3()
  call assert_true(v:false)
endfunction

function! g:test_suit.test.autoload.x2()
  call assert_true(v:false)
endfunction

function! g:test_suit.test.autoload.x1()
  call assert_true(v:false)
endfunction
