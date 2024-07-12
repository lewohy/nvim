-- leader 키
vim.g.mapleader = '\\'

-- line number
vim.opt.number = true

-- 백스페이스가 들여쓰기 삭제, 줄바꿈 삭제, 삽입모드에서 삭제 가능
vim.opt.backspace = 'indent,eol,start'

-- 키 시퀀스의 타임아웃 비활성화
vim.opt.timeout = false

-- gui 모드에서 폰트 설정
vim.opt.guifont = { 'JetBrainsMono Nerd Font', ':h10' }

-- 현재 커서의 줄 하이라이팅
vim.opt.cursorline = true
-- vim.api.nvim_set_hl(0, 'Cursor', {
--     ctermfg = 1
-- })

-- 탭문자의 길이는 4로 설정
vim.opt.tabstop = 4

-- 들여쓰기시 공백 갯수 설정
vim.opt.shiftwidth = 4

-- 들여쓰기 문자를 공백으로 설정
vim.opt.expandtab = true

-- 검색된 문자 하이라이팅
vim.opt.hlsearch = true

-- 검색시 대소문자 구분하지 않음
vim.opt.ignorecase = true

-- 검색어에 대소문자 있으면 구분
vim.opt.smartcase = true

-- 검색어 실시간 하이라이팅 설정
vim.opt.incsearch = true

-- 자동 들여쓰기 설정
vim.opt.smartindent = true

-- 다음줄 들여쓰기 설정
vim.opt.autoindent = true

-- 탭 키의 삽입할 공백 수와 백스페이스의 삭제할 공백 문자 수 설정
vim.opt.softtabstop = 1

-- paste
vim.opt.paste = false

-- undo
vim.opt.history = 1000

vim.opt.undolevels = 1000

-- undo dir설정
vim.opt.undodir = vim.fn.stdpath('data') .. '/undodir'

-- undofile 활성화
vim.opt.undofile = true

-- 스크롤 오프셋 설정
vim.opt.scrolloff = 3

-- clipboard 사용
vim.opt.clipboard = 'unnamedplus'

vim.opt.termguicolors = true

if vim.g.vscode then vim.opt.shada = '' end

vim.opt.background = 'dark'
