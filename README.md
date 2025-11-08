# adder-Test 2

## Release Note

This is a Verilog project meant to compare the speed and resource usage between Ripple-Carry, Carry-Lookahead, and Prefix Adders. This is done by measuring their critical-path delays, estimated maximum frequencies, and area, then considering their practical tradeoffs. These summarized outcomes can be found in results/results.md.

To run the simulations, execute the run_sim.sh file with `./tb/run_sim.sh` but first make the script executable with `chmod +x tb/run_sim.sh`. For synthesis, execute the measure.sh file with `./synth/measure.sh` but first make the script executable with `chmod +x synth/measure.sh`. Read below if interested in running the terminal commands yourself.

### Git Workflow

1. To create the git repo, use `git init` then `git remote add origin <repo_url>`
2. Use `git checkout -b <branch_name>` to create and work on feature branches
3. Use `git add <file_name>` to stage changes and `git commit -m "subject: description"` to commit them to branch
4. Push branch into mainline with `git push -u origin <branch_name>`
5. Steps 2-4 should be repeated as needed to complete adder implementations.

### Icarus Instructions

This project makes uses of Icarus Verilog, which will allow you to run the code in this repo. These steps assume you've already set up Icarus Verilog on your Mac.

1. Use `iverilog -o test_adders adder_rt1/rca.v adder_rt1/prefix.v adder_rt1/cla.v adder_rt1/tb_adders.v` to compile the code.
2. Use `vvp test_adders` to run the simulation from the compiled code. You should have the test cases print on your terminal.

### GTKWave Instructions

This project required the use of GTKWave for waveform visualization. However, installing it directly from Homebrew will lead to incompatibility with the newer
MacOS versions. Instead, these steps must be followed:

1. Use `brew install gtk+3 gtk-mac-integration tcl-tk xz` to install necessary MacOS dependencies.
2. From the root directory (cd ~), clone and enter the GTKWave repository using `git clone https://github.com/gtkwave/gtkwave` then `cd gtkwave`.
3. The repository must be built with Meson using the following commands in order: `meson setup build --prefix=/usr/local`, `meson compile -C build`, and `sudo meson install -C build`.

If you run into dependency issues with Meson, the following installation commands might be useful: `brew install meson`, `brew install pkg-config glib`, `brew install gtk4`, `brew install gobject-introspection`, `brew install desktop-file-utils`, or `brew install shared-mime-info`.

Once GTKWave is built successfully, run `gtkwave tb_waveforms.vcd` to open the generated waveforms.
