alias st="settle"
alias stq="settle query"
alias stge="settle generate"
alias stfl="settle links"
alias stbl="settle backlinks"
alias stls="settle ls"
alias stf="settle find"
alias sts="settle search"
alias stnc="settle not-created"

alias stn="settle new"
alias stnp="settle new --project"
alias stni="settle new --project 'inbox'"
alias stnl="settle new --project 'literature'"

function vste() {
    nvim -c "FZF $(settle zk)"
}
