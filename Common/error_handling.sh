function start_script {
    starting_time_of_this_script=`date +%s`

    set -eu # set -o errexit/nounset

    echo program: $0 >&2
    echo params: "$@" >&2
    echo time: `date` >&2
    echo cwd: `pwd` >&2

    set -x
}

function script_start {
    start_script
}

function end_script {
    set +x
    echo DONE $0 "ON" `date` >&2
    ending_time_of_this_script=`date +%s`
    echo Time elapsed: $(($ending_time_of_this_script-$starting_time_of_this_script)) seconds >&2
}

function script_end {
    end_script
}

function error_exit {
    echo error_exit: line $LINENO
}
