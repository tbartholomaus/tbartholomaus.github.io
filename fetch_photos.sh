#!/bin/bash
# Downloads every photo, figure and PDF the new site uses from the old
# WordPress site, plus the two Best WordPress Gallery photo galleries.
# Run once from this folder:   bash fetch_photos.sh
cd "$(dirname "$0")"
ok=0; fail=0; bad=0
while IFS=$'\t' read -r url path; do
  [ -z "$url" ] && continue
  [ -s "$path" ] && { ok=$((ok+1)); continue; }
  mkdir -p "$(dirname "$path")"
  if curl -sfL --max-time 60 -o "$path" "$url"; then
    # Safety check: keep only real images/PDFs/icons
    mime=$(file -b --mime-type "$path")
    case "$mime" in
      image/*|application/pdf|image/vnd.microsoft.icon) ok=$((ok+1));;
      *) echo "REMOVED (not an image/PDF: $mime): $path"; rm -f "$path"; bad=$((bad+1));;
    esac
  else
    echo "FAILED: $url"; rm -f "$path"; fail=$((fail+1))
  fi
done < download-list.txt
echo "Files: $ok ok, $fail failed, $bad removed"

# --- Photo galleries (stored by a plugin, not in the WordPress export) ---
for pair in "yahtse-photos:yahtse" "uummannaq-photos:greenland"; do
  slug=${pair%%:*}; name=${pair##*:}
  urls=$(curl -sfL --max-time 60 "http://tbartholomaus.org/$slug/" \
    | grep -oE 'https?://(www\.)?tbartholomaus\.org/wp-content/uploads/photo-gallery/[^"'"'"' )?]+\.(jpe?g|png|JPE?G|PNG)' \
    | sed -E 's#/photo-gallery/thumb/#/photo-gallery/#' | sort -u)
  n=0; html=""
  for u in $urls; do
    f="images/galleries/$name/$(basename "$u")"
    mkdir -p "$(dirname "$f")"
    [ -s "$f" ] || curl -sfL --max-time 60 -o "$f" "$u"
    if [ -s "$f" ] && file -b --mime-type "$f" | grep -q '^image/'; then
      html="$html<a href=\"../$f\"><img src=\"../$f\" alt=\"\" loading=\"lazy\"></a>"; n=$((n+1))
    else rm -f "$f"; fi
  done
  if [ $n -gt 0 ]; then
    perl -0pi -e "s#<div class=\"gallery\" data-gallery=\"$name\">.*?</div>#<div class=\"gallery\" data-gallery=\"$name\">$html</div>#s" "photos/$name.html"
  fi
  echo "Gallery $name: $n photos"
done
