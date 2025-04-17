#!/bin/bash

# Basic Bug Bounty Recon Script 🚀
# Author: Devil✨

source ./banner.sh
clear
printbanner

domain=$1

if [ -z "$domain" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

echo "🔍 Starting recon for: $domain at $(date +%T)"


# Create output directory
mkdir -p recon/$domain
cd recon/$domain || exit

# Subdomain Enumeration 🕵️‍♂️
echo "📦 Gathering subdomains..."
subfinder -d $domain -silent > subdomains.txt
assetfinder --subs-only $domain >> subdomains.txt
sort -u subdomains.txt -o subdomains.txt

# Probing live domains 🌐
echo "📡 Probing for live domains..."
cat subdomains.txt | httpx-toolkit -sc -silent -probe > live.txt

echo "🧹 Cleaning the live domains..."
sed -E 's/^(https?:\/\/[^ ]+).*/\1/' live.txt > cleaned.txt


# Done ✅
echo "🎯 Recon completedat $(date +%T)"
echo "✅Results saved in recon/$domain/"
