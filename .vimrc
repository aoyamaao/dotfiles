" 最小限の必須設定
filetype plugin indent on
syntax on

" フォーカスイベントを検知したらメッセージを出すだけのテスト関数
function! s:TestFocus(event_name)
  echom "EVENT DETECTED: " . a:event_name
endfunction

" tmuxが送るエスケープシーケンスを直接autocmdで捕捉する
if exists('$TMUX')
  autocmd! TermResponse * if v:termresponse =~ "\e\[I" | call s:TestFocus('Focus Gained') | endif
  autocmd! TermResponse * if v:termresponse =~ "\e\[O" | call s:TestFocus('Focus Lost') | endif
endif
