{
  flake.nixosModules.keyboard = {...}: {
    # Keyboard module

    # home row mods
    services.kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          devices = [
            # xps13 keyboards
            "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
            "/dev/input/by-path/pci-0000:00:14.0-usb-0:8.3.3.4:1.1-event-kbd"
            "/dev/input/by-path/pci-0000:00:14.0-usbv2-0:8.3.3.4:1.1-event-kbd"

            # performus keyboard
            "/dev/input/by-path/pci-0000:00:14.0-usbv2-0:7.4:1.1-event-kbd"
          ];
          extraDefCfg = "process-unmapped-keys yes";
          config = ''
            (defsrc
              esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rmet rctl
            )
            (defvar
              tap-time 150
              hold-time 200
            )
            (defalias
              vl2 (tap-hold $tap-time $hold-time v (layer-toggle layerTwo))
              nl2 (tap-hold $tap-time $hold-time n (layer-toggle layerTwo))
              cap (tap-hold $tap-time $hold-time esc lsft)
              a (tap-hold $tap-time $hold-time a lmet)
              s (tap-hold $tap-time $hold-time s lalt)
              d (tap-hold $tap-time $hold-time d lsft)
              f (tap-hold $tap-time $hold-time f lctl)
              j (tap-hold $tap-time $hold-time j rctl)
              k (tap-hold $tap-time $hold-time k rsft)
              l (tap-hold $tap-time $hold-time l ralt)
              ; (tap-hold $tap-time $hold-time ; rmet)
            )
            (deflayer base
              esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              @cap @a   @s   @d   @f   g    h    @j   @k   @l   @;   '    ret
              lsft z    x    c    @vl2 b    @nl2 m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rmet rctl
            )
            (deflayer layerTwo
              _    _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              _    S-1  S-2  S-3  S-4  S-5  S-6  S-7  S-8  S-9  S-0  _    _    _
              caps S-6  S-7  S-8  S-9  S-0  left down up   rght _    _    _
              _    ⇤    ⇥    ⇞    ⇟    del  -    S--  =    S-=  \    S-\
              _    _    _              _              _    _    _
            )
          '';
        };
      };
    };

    # Keyboard module end.
  };
}
