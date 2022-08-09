alias st="settle"
alias stq="settle query"
alias stge="settle generate"
alias stfl="settle links"
alias stbl="settle backlinks"
alias stls="settle ls"
alias stf="settle find"
alias sts="settle search"
alias stnc="settle not-created"

function vstn() {
    nvim -c "SettleNew '',\"$1\""
}

function vstnp() {
    nvim -c "SettleNew '$1',\"$2\""
}

function vstni() {
    nvim -c "SettleNew 'inbox',\"$1\""
}

function vste() {
    nvim -c "SettleEdit"
}
