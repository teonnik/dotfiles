-- Hyprland config, migrated from hyprland.conf (hyprlang) to Lua.
-- API reference: /usr/share/hypr/stubs/hl.meta.lua and
-- https://wiki.hypr.land/Configuring/Basics/

------------------
---- MONITORS ----
------------------

-- Monitors are managed by shikane (~/.config/shikane/config.toml).
-- Historical layouts kept for reference:
--   Laptop:                 eDP-1 preferred 0x0    scale 1
--   Katie's office Harwell: eDP-1 960x1080, DP-7 0x0, DP-6 1920x0


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("mako")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("waybar -c ~/.config/waybar/config-laptop.jsonc -s ~/.config/waybar/style.css")
    hl.exec_cmd("blueman-applet")
    -- hl.exec_cmd("signal-desktop --use-tray-icon --enable-features=UseOzonePlatform --ozone-platform=wayland")
    hl.exec_cmd("swayidle -w " ..
        "before-sleep 'swaylock -f' " ..
        "timeout 180 'notify-send -u critical \"Locking screen in 2 minutes.\" \"The system was idle for 3 minutes.\"' " ..
        "timeout 300 'swaylock -f' " ..
        "timeout 360 'hyprctl dispatch dpms off' " ..
        "resume 'hyprctl dispatch dpms on'")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("shikane")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- https://wiki.hypr.land/Nvidia/
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- https://wiki.hypr.land/Configuring/Multi-GPU/
hl.env("AQ_DRM_DEVICES", "/dev/dri/card1")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        -- To save on battery disable shadow and blur
        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled  = true,
            size     = 4,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = false,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
        enable_anr_dialog       = false, -- https://github.com/hyprwm/Hyprland/discussions/9756
    },

    input = {
        kb_layout  = "us,bg",
        kb_variant = ",phonetic",
        kb_options = "grp:alt_shift_toggle",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Animation curves + timings (inert while animations.enabled = false, kept for parity)
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}   } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}   } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}      } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1.0} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}    } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- Blur fuzzel's backdrop, like windows get from decoration.blur above
hl.layer_rule({
    name  = "blur-launcher",
    match = { namespace = "launcher" },
    blur  = true,
})


---------------
---- INPUT ----
---------------

-- Example per-device config
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return",        hl.dsp.exec_cmd("foot"))
hl.bind(mainMod .. " + D",             hl.dsp.exec_cmd("fuzzel"))
hl.bind(mainMod .. " + SHIFT + D",     hl.dsp.exec_cmd("foot mydocs"))
hl.bind(mainMod .. " + L",             hl.dsp.exec_cmd("swaylock"))
hl.bind(mainMod .. " + P",             hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))

hl.bind(mainMod .. " + SHIFT + Q",     hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.float())
hl.bind(mainMod .. " + E",             hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + P",     hl.dsp.exec_cmd("~/bin/power-menu-fuzzel.sh"))
hl.bind(mainMod .. " + F",             hl.dsp.window.fullscreen())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

-- Move the focused window
hl.bind(mainMod .. " + SHIFT + Left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + Up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + Down",  hl.dsp.window.move({ direction = "d" }))

-- Switch workspaces + move active window to a workspace with mainMod + [SHIFT +] [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move current workspace between monitors
hl.bind(mainMod .. " + CONTROL + Left",  hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + CONTROL + Right", hl.dsp.workspace.move({ monitor = "r" }))
hl.bind(mainMod .. " + CONTROL + Up",    hl.dsp.workspace.move({ monitor = "u" }))
hl.bind(mainMod .. " + CONTROL + Down",  hl.dsp.workspace.move({ monitor = "d" }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
hl.bind(mainMod .. " + A",         hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind(mainMod .. " + M",         hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))

-- Brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 5%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd("brightnessctl set +5%"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("brightnessctl set 5%-"))

-- Keyboard backlight
hl.bind(mainMod .. " + K",         hl.dsp.exec_cmd("brightnessctl --device='tpacpi::kbd_backlight' set 2"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("brightnessctl --device='tpacpi::kbd_backlight' set 0"))

-- Media player
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"))


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Ignore maximize requests from apps.
hl.window_rule({
    name           = "suppress-maximize",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_initial_focus = true,
})

-- Make terminal slightly transparent
hl.window_rule({
    name    = "foot-opacity",
    match   = { class = "foot" },
    opacity = "0.85",
})

-- Set border color to red for Xwayland windows
hl.window_rule({
    name         = "xwayland-border",
    match        = { xwayland = true },
    border_color = "rgb(FF0000) rgb(880808)",
})
