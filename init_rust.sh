RustPackages=("wasm-pack")

for i in "${RustPackages[@]}"
do
  cargo install "$i"
done