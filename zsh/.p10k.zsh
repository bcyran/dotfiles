unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    context
    dir
    vcs
    prompt_char
)

typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status
    command_execution_time
    background_jobs
    kubecontext
    virtualenv
    vim_shell
)

typeset -g POWERLEVEL9K_MODE=nerdfont-complete
typeset -g POWERLEVEL9K_ICON_PADDING=moderate

typeset -g POWERLEVEL9K_BACKGROUND=
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=

typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=2
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=1

typeset -g POWERLEVEL9K_DIR_FOREGROUND=4
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=4
typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=4
typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
local anchor_files=(
    .git
    pyproject.toml
    setup.cfg
    setup.py
    Cargo.toml
    package.json
)
typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80
typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50
typeset -g POWERLEVEL9K_DIR_HYPERLINK=false
typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v2
typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3
typeset -g POWERLEVEL9K_DIR_CLASSES=()

typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=
typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

function my_git_formatter() {
    emulate -L zsh

    if [[ -n $P9K_CONTENT ]]; then
        typeset -g my_git_format=$P9K_CONTENT
        return
    fi

    if (( $1 )); then
        local       meta='%f'
        local      clean='%2F'
        local   modified='%3F'
        local  untracked='%4F'
        local conflicted='%1F'
    else
        local       meta='%f'
        local      clean='%f'
        local   modified='%f'
        local  untracked='%f'
        local conflicted='%f'
    fi

    local res

    if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
        local branch=${(V)VCS_STATUS_LOCAL_BRANCH}
        (( $#branch > 32 )) && branch[13,-13]="…"  # <-- this line
        res+="${clean}${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}${branch//\%/%%}"
    fi

    if [[ -n $VCS_STATUS_TAG
            && -z $VCS_STATUS_LOCAL_BRANCH  # <-- this line
        ]]; then
        local tag=${(V)VCS_STATUS_TAG}
        (( $#tag > 32 )) && tag[13,-13]="…"  # <-- this line
        res+="${meta}#${clean}${tag//\%/%%}"
    fi

    [[ -z $VCS_STATUS_LOCAL_BRANCH && -z $VCS_STATUS_TAG ]] &&  # <-- this line
        res+="${meta}@${clean}${VCS_STATUS_COMMIT[1,8]}"

    if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
        res+="${meta}:${clean}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"
    fi

    (( VCS_STATUS_COMMITS_BEHIND )) && res+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
    (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && res+=" "
    (( VCS_STATUS_COMMITS_AHEAD  )) && res+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
    (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
    (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" "
    (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && res+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
    (( VCS_STATUS_STASHES        )) && res+=" ${clean}*${VCS_STATUS_STASHES}"
    [[ -n $VCS_STATUS_ACTION     ]] && res+=" ${conflicted}${VCS_STATUS_ACTION}"
    (( VCS_STATUS_NUM_CONFLICTED )) && res+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
    (( VCS_STATUS_NUM_STAGED     )) && res+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
    (( VCS_STATUS_NUM_UNSTAGED   )) && res+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
    (( VCS_STATUS_NUM_UNTRACKED  )) && res+=" ${untracked}${(g::)POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}"
    (( VCS_STATUS_HAS_UNSTAGED == -1 )) && res+=" ${modified}─"

    typeset -g my_git_format=$res
}
functions -M my_git_formatter 2>/dev/null

typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1
typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'
typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter(1)))+${my_git_format}}'
typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION='${$((my_git_formatter(0)))+${my_git_format}}'
typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1
typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_COLOR=2
typeset -g POWERLEVEL9K_VCS_LOADING_VISUAL_IDENTIFIER_COLOR=
typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_EXPANSION=
typeset -g POWERLEVEL9K_VCS_PREFIX='%fon '
typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)
typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=2
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=2
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=3

typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
typeset -g POWERLEVEL9K_STATUS_OK=false
typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=2
typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION='✔'
typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=2
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION='✔'
typeset -g POWERLEVEL9K_STATUS_ERROR=false
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=1
typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='✘'
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND=1
typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_VISUAL_IDENTIFIER_EXPANSION='✘'
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=1
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION='✘'

typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=3
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION=
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PREFIX='%ftook '

typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=true
typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=1

typeset -g POWERLEVEL9K_VIM_SHELL_FOREGROUND=3

typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=1
typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_FOREGROUND=7
typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=7
typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE='%B%n@%m'
typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_TEMPLATE='%n@%m'
typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'
typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION=

typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=6
typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=

typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm'
typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=(
    # '*prod*'  PROD    # These values are examples that are unlikely
    # '*test*'  TEST    # to match your needs. Customize them as needed.
    '*'       DEFAULT)
typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND=134
typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION=
POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${P9K_KUBECONTEXT_CLOUD_CLUSTER:-${P9K_KUBECONTEXT_NAME}}'
POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${${:-/$P9K_KUBECONTEXT_NAMESPACE}:#/default}'

typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off
typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose
typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

# If p10k is already loaded, reload configuration.
# This works even with POWERLEVEL9K_DISABLE_HOT_RELOAD=true.
(( ! $+functions[p10k] )) || p10k reload
