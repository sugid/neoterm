let s:test_files = filter(
      \ globpath(&rtp, "test/**/*_test.vim", 0, 1),
      \ "v:val =~ 'neoterm'"
      \ )

for file in s:test_files
  exec "source ".file
endfor

" How to write on STDOUT?
call g:test_suit.run()
