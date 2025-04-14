#!/usr/bin/env python3

# 🔥 Advanced Recon Automation Tool
# ✍️ Author: DevilHacksIt

import os
import argparse
import subprocess

parser = argparse.ArgumentParser(description="Advanced Recon Tool by DevilHacksIt")
parser.add_argument("domain", help="Target domain (e.g., example.com)")
args = parser.parse_args()
domain = args.domain

outdir = f"output/{domain}"
os.makedirs(outdir, exist_ok=True)

def run(cmd, output_file):
    print(f"🛠️ Running: {cmd}")
    with open(output_file, 'w') as f:
        subprocess.run(cmd, shell=True, stdout=f, stderr=subprocess.DEVNULL)

# Subdomain enumeration
run(f"subfinder -d {domain} -silent", f"{outdir}/subfinder.txt")
run(f"assetfinder --subs-only {domain}", f"{outdir}/assetfinder.txt")

# Combine and dedupe
with open(f"{outdir}/subdomains.txt", 'w') as out:
    subs = set(open(f"{outdir}/subfinder.txt").read().splitlines() +
               open(f"{outdir}/assetfinder.txt").read().splitlines())
    for sub in sorted(subs):
        out.write(sub + "\n")

# Live subdomains
run(f"httpx -l {outdir}/subdomains.txt -silent", f"{outdir}/live.txt")

# Port scan
run(f"naabu -host {domain} -silent", f"{outdir}/ports.txt")

# Wayback URLs
run(f"cat {outdir}/live.txt | waybackurls", f"{outdir}/wayback.txt")

print(f"✅ Recon completed! Check output in {outdir}")
