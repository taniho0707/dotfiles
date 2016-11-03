# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os, subprocess

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget
from libqtile import hook

mod = "mod4"

def is_running(process):
    s = subprocess.Popen(["ps", "axw"], stdout=subprocess.PIPE)
    for x in s.stdout:
        if re.search(process, x):
            return True
    return False

def execute_once(process):
    if not is_running(process):
        return subprocess.Popen(process.split())

# running startup script
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

keys = [
    # Switch between windows in current stack pane
    Key(
        [mod], "k",
        lazy.layout.down()
    ),
    Key(
        [mod], "j",
        lazy.layout.up()
    ),

    # Move windows up or down in current stack
    Key(
        [mod, "control"], "k",
        lazy.layout.shuffle_down()
    ),
    Key(
        [mod, "control"], "j",
        lazy.layout.shuffle_up()
    ),

    # Switch window focus to other pane(s) of stack
    Key(
        [mod], "space",
        lazy.layout.next()
    ),

    # rofi launcher
    Key(
        [mod], 'l',
        lazy.spawn(
            "rofi -show drun -font \"snap 10\" -fg \"#505050\" -bg \"#000000\" -hlfg \"#ffb964\" -hlbg \"#000000\" -o 85 -kb-cancel 'Escape,Control+g' -kb-mode-next 'Control+i'")
    ),
    
    # Swap panes of split stack
    Key(
        [mod, "shift"], "space",
        lazy.layout.rotate()
    ),
    
    # # Toggle between split and unsplit sides of stack.
    # # Split = all windows displayed
    # # Unsplit = 1 window displayed, like Max layout, but still with
    # # multiple stack panes
    # Key(
    #     [mod, "shift"], "Return",
    #     lazy.layout.toggle_split()
    # ),

    # do not work...
    Key([], "Print", lazy.spawn("maim ~/Pictures/screenshot/$(date +%F-%T).png")),
    Key(["mod1"], "Print", lazy.spawn("maim -i $(xdotool getactivewindow) ~/Pictures/screenshot/$(date +%F-%T).png")),
    Key(['shift'], 'Print', lazy.spawn("maim --select ~/Pictures/screenshot/$(date +%F-%T).png")),
    
    Key(
        [mod, 'shift'], 'Return',
        lazy.spawn("termite -e /usr/bin/tmux")
    ),
    Key([mod], "Return", lazy.spawn("termite")),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key(
        [mod, "shift"], 'l',
        lazy.spawn("xscreensaver-command -lock")
    ),
    Key([mod, "control"], "s", lazy.spawn("systemctl suspend")),
    Key([mod], "r", lazy.spawncmd()),

    # Sound
    Key([], "XF86AudioMute", lazy.spawn("amixer -q -D pulse set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 0 -D pulse sset Master 1%- unmute")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 0 -D pulse sset Master 1%+ unmute")),

    # Brightness
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 5")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 5")),
]

groups = [Group(i) for i in "asdfuiop"]

for i in groups:
    # mod1 + letter of group = switch to group
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )

    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
    )

layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2)
]

widget_defaults = dict(
    font='Hiragino Mincho Pro',
    fontsize=12,
    padding=0,
)

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.Sep(),
                widget.WindowName(),
                widget.Notify(),
                # widget.CPUGraph(border_width=1),
                widget.Sep(),
                widget.Memory(fmt="{MemAvailable}M"),
                widget.Sep(),
                
                widget.Net(),
                widget.Volume(),
                widget.Systray(),
                widget.Battery(font="Hiragino Mincho Pro", format='{char}.{percent:2.0%}({hour:d}:{min:02d})'),
                widget.Sep(),
                
                widget.Clock(format=' %Y/%m/%d(%a) %H:%M '),
                widget.Image(filename='~/Pictures/icon/pochi.png'),
            ],
            18,
        ),
    ),
    Screen(),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
