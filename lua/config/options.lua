vim.opt.timeout = false -- 키 시퀀스의 타임아웃 비활성화

vim.opt.guifont = "JetBrainsMono Nerd Font:h10:w-0.2" -- gui 모드에서 폰트 설정

vim.opt.expandtab = true -- 탭을 공백으로 변환
vim.opt.tabstop = 4 -- 탭문자 4칸으로 표시
vim.opt.shiftwidth = 4 -- `>>`, `<<` 들여쓰기 시 공백 수 설정
vim.opt.softtabstop = 4 -- 탭 키를 누를 때 공백 수 설정

vim.opt.relativenumber = false -- Relative line numbers

vim.opt.ignorecase = true -- 검색시 대소문자 구분하지 않음
vim.opt.smartcase = true -- 검색어에 대소문자가 섞여있으면 대소문자 구분
vim.opt.incsearch = true -- 검색어 실시간 하이라이팅 설정

vim.opt.paste = false -- 붙여넣기시 자동 들여쓰기

vim.opt.history = 10000 -- 명령어 히스토리 저장 개수 설정

vim.opt.undolevels = 10000 -- undo 레벨 설정
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir" -- undo dir설정
vim.opt.undofile = true -- undofile 활성화

vim.opt.scrolloff = 100 -- 스크롤 오프셋 설정

vim.opt.completeopt = "menu,preview,noinsert" -- 자동완성시 메뉴와 미리보기 활성화, 자동으로 입력하지 않음

vim.opt.termguicolors = true -- 24비트 색상 사용

-- vim.opt.fileformat = "unix" --
vim.opt.fileformat = "unix"
vim.opt.fileformats = "unix,dos"

if vim.g.vscode then
	vim.opt.shada = ""
end

-- vim.opt.background = 'dark'

vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("W", "w", {})

vim.cmd.colorscheme "catppuccin-mocha" -- 테마 설정. colorscheme.lua보다 늦게 설정되어야함
vim.opt.number = true
vim.opt.clipboard = "unnamedplus" -- 시스템 클립보드 사용

-- vim.opt.wildmode = "longest:full,full"
