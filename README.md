Hardened container that runs a Windows Elixir Burrito under Proton, with the BEAM supervising fdbserver.exe and bao.exe.

    pixi run build     # builds the image (pinned Proton and umu, hash-checked)
    APP_DIR=/path/to/burrito DATA_DIR=/path/to/data pixi run run
    pixi run health
    pixi run check

The root is read-only, all capabilities are dropped, memory, pids and logs are bounded, and a failed health check restarts the container.
