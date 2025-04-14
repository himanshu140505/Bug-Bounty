#!/bin/bash

# 🔥 Advanced Recon Automation Script
# ✍️ Author: DevilHacksIt

domain=$1

if [ -z "$domain" ]; then
  echo "❌ Usage: $0 <domain>"
  exit 1
fi

echo "🚀 Starting Advanced Recon on: $domain"

# Setup
OUTDIR="output/$domain"
mkdir -p "$OUTDIR"

# Subdomain Enumeration
echo "🔍 Finding subdomains..."
subfinder -d "$domain" -silent > "$OUTDIR/subdomains.txt"
assetfinder --subs-only "$domain" >> "$OUTDIR/subdomains.txt"
cat "$OUTDIR/subdomains.txt" | sort -u > "$OUTDIR/subs_clean.txt"

# Probing for live domains
echo "🌐 Checking live subdomains..."
httpx -l "$OUTDIR/subs_clean.txt" -silent > "$OUTDIR/live.txt"

# Port scanning
echo "🚪 Running port scan..."
naabu -host "$domain" -silent > "$OUTDIR/ports.txt"

# Wayback URLs
echo "🕰️ Pulling Wayback Machine URLs..."
cat "$OUTDIR/live.txt" | waybackurls > "$OUTDIR/wayback.txt"

# Final
echo "✅ Recon completed! Data saved in: $OUTDIR"
