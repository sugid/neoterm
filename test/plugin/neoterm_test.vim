execute "source ".globpath(&rtp, "test/test_helper.vim")

let g:test_suit.test.plugin = {}

function! g:test_suit.test.plugin.next_id()
  let g:neoterm.last_id = 0

  call assert_equal(1, g:neoterm.next_id())
endfunction

function! g:test_suit.test.plugin.has_any()
  let g:neoterm.next_id()
  let g:neoterm.instances = { "a": 1 }

  call assert_true(g:neoterm.has_any())
endfunction
