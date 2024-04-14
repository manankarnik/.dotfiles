#!/usr/bin/env bash

workspaces() {
  # {title: "", active: 1, workspaces: [{id: 1, windows: 2}, ...]}
  active=$(hyprctl activeworkspace -j | jq ".id")
  title=$(hyprctl activeworkspace -j | jq ".lastwindowtitle")
  hyprctl workspaces -j \
    | jq "map({id, windows})" \
    | jq '[range(1;11) as $i | {id: $i, windows: ((.[] | select(.id == $i).windows)//0)}]' \
    | jq -c "{title: $title, active: $active, workspaces: .}"
}

workspaces
  bspc subscribe desktop node_transfer | while read -r _ ; do
workspaces
done
