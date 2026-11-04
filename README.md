# UI Glacier Dynamics website (rebuilt from tbartholomaus.org)

A static site for GitHub Pages, generated from the WordPress export (all 76 news posts, 21 pages, team, CV, publications). No build step, no plugins, no login.

## 1. Pull in the photos (once)
On your Mac, from this folder:

    bash fetch_photos.sh

This downloads every photo, figure and paper PDF the pages use (listed in `download-list.txt`) from the old site, plus the two photo galleries. Anything that isn't a real image or PDF is deleted automatically. Re-run it any time; it skips files it already has.

## 2. Publish
1. Your GitHub account `tbartholomaus` already hosts the lab manual at `tbartholomaus.github.io/uiglaciology/`. Create a repo named exactly `tbartholomaus.github.io` (if it doesn't exist) — the lab manual keeps working at its current address.
2. Push everything in this folder (including `.nojekyll`) to `main`.
3. Repo Settings → Pages → Deploy from branch `main`, folder `/ (root)`.
4. Optional, to keep tbartholomaus.org: add a `CNAME` file containing `tbartholomaus.org`, point the domain's DNS at GitHub Pages, and tick "Enforce HTTPS".

## Notes
- Old WordPress URLs like `/our-team/` map to `team.html`, etc. Links between pages are relative, so the site also works when opened locally.
- The Calving Validation data archive (`research/calving-validation-archive.html`) still links to the `.hdf5` / metadata files on the old server. Move those to Zenodo or similar (GitHub rejects files over 100 MB) and update the links before retiring the old host.
