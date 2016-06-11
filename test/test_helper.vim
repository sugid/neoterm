if !exists("g:test_suit")
  let g:test_suit = { "test": {} }
end

function! g:test_suit.run()
  let g:test_suit.counter = { "succeed": 0, "failed": 0 }
  let g:test_suit.failures = []
  echo ""
  call s:run_cases(self.test)
  echo printf(
        \ "Succeed: %s, Failed: %s",
        \ self.counter.succeed,
        \ self.counter.failed
        \ )
endfunction

function! s:run_cases(cases)
  for test_case in items(a:cases)
    let [description, tests] = test_case

    call s:run_tests(description, tests)
  endfor

  for failure in g:test_suit.failures
    echohl DiffRemoved
    echo failure
    echohl None
  endfor
endfunction

function! s:run_tests(test_case, tests)
  for test in items(a:tests)
    let v:errors = [] " reset errors
    let [description, Fn] = test

    silent call call(Fn, [], a:tests)

    if !empty(v:errors)
      let g:test_suit.counter.failed += 1
      echohl DiffRemoved
      echon printf("%s", 'F')
      call s:save_errors(a:test_case, description)
    else
      let g:test_suit.counter.succeed += 1
      echohl DiffAdd
      echon printf("%s", ".")
    end
  endfor

  echohl None
endfunction

function! s:save_errors(test_case, description)
  for error in v:errors
    let [functions, errormsg] = split(error, ': ')
    call add(
          \ g:test_suit.failures,
          \ printf("%s.%s: %s", a:test_case, a:description, errormsg)
          \ )
  endfor
endfunction
