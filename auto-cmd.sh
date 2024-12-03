#!/bin/bash
set +e

message() {
    echo "Please run:" >&2
    echo "            $0 pack [CHART]       " >&2
    echo "            $0 push [CHART] [REPO]" >&2
}

pack_chart() {
    echo -e "\e[0;31mPacking chart...\e[0m"
    helm repo index $1
    helm package $1
}

push_chart() {
    echo -e "\e[0;31mPushing chart: $1...to repo: $2...\e[0m"
    helm cm-push --force $1 $2 && helm repo update;
}

<<COMMENT
MULTILINE COMMAND
COMMENT

case "$1" in
    pack)
        sleep 1
        if [ "$#" -ne 2 ]; then
            message;
            exit 1
        fi
        pack_chart $2;
        ;;
    push)
        sleep 1
        if [ "$#" -ne 3 ]; then
            message;
            exit 1
        fi
        push_chart $2 $3;
        ;;
    *)
        message;
        exit 1
        ;;
esac
exit 0
