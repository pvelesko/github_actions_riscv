#!/bin/bash

# Set workspace directory
WORKSPACE=$(pwd)

# Clone repositories
git clone https://github.com/dkurt/runner.git --branch origin/dkurt/riscv64_runner

# Download .NET
wget https://github.com/pvelesko/dotnet_riscv/releases/download/v8.0.101/dotnet-sdk-8.0.101-linux-riscv64.tar.gz
mkdir $WORKSPACE/packages
cd $WORKSPACE/packages

# Download packages
wget https://github.com/pvelesko/dotnet_riscv/releases/download/v8.0.101/Microsoft.AspNetCore.App.Runtime.linux-riscv64.8.0.1-servicing.23580.8.nupkg
wget https://github.com/pvelesko/dotnet_riscv/releases/download/v8.0.101/Microsoft.AspNetCore.App.Runtime.linux-riscv64.8.0.1-servicing.23580.8.symbols.nupkg
wget https://github.com/pvelesko/dotnet_riscv/releases/download/v8.0.101/Microsoft.AspNetCore.App.Runtime.linux-riscv64.8.0.1.nupkg
wget https://github.com/pvelesko/dotnet_riscv/releases/download/v8.0.101/Microsoft.AspNetCore.App.Runtime.linux-riscv64.8.0.1.symbols.nupkg
wget https://github.com/pvelesko/dotnet_riscv/releases/download/v8.0.101/Microsoft.NETCore.App.Host.linux-riscv64.8.0.1.nupkg
wget https://github.com/pvelesko/dotnet_riscv/releases/download/v8.0.101/Microsoft.NETCore.App.Host.linux-riscv64.8.0.1.symbols.nupkg
wget https://github.com/pvelesko/dotnet_riscv/releases/download/v8.0.101/Microsoft.NETCore.App.Runtime.linux-riscv64.8.0.1-servicing.23580.1.nupkg
wget https://github.com/pvelesko/dotnet_riscv/releases/download/v8.0.101/Microsoft.NETCore.App.Runtime.linux-riscv64.8.0.1-servicing.23580.1.symbols.nupkg
wget https://github.com/pvelesko/dotnet_riscv/releases/download/v8.0.101/Microsoft.NETCore.App.Runtime.linux-riscv64.8.0.1.nupkg
wget https://github.com/pvelesko/dotnet_riscv/releases/download/v8.0.101/Microsoft.NETCore.App.Runtime.linux-riscv64.8.0.1.symbols.nupkg

# Prepare
cd $WORKSPACE/runner
sed -i "s|/home/ubuntu/packages|$WORKSPACE|" src/NuGet.Config

mkdir -p _dotnetsdk/8.0.101
cd _dotnetsdk/8.0.101
tar -xf $WORKSPACE/dotnet-sdk-8.0.101-linux-riscv64.tar.gz

# Build
cd $WORKSPACE/runner/src
./dev.sh layout Release linux-riscv64

# Package
./dev.sh package Release linux-riscv64

echo "Build complete. Package is available in $WORKSPACE/runner/_package/actions-runner-linux-riscv64-*.tar.gz"