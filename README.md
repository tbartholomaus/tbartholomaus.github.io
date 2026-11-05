# UI Glacier Dynamics website

The lab website for the Glacier Dynamics Group at the University of Idaho, served from GitHub Pages at [tbartholomaus.github.io](https://tbartholomaus.github.io/). Plain HTML and CSS — no build step, no plugins, no login. Originally generated from a WordPress export of tbartholomaus.org.

## Editing

Edit the `.html` files directly. The site is formatted with [Prettier](https://prettier.io/); after changing any HTML, run:

    npx prettier --print-width 100 --write "*.html" "news/*.html" "research/*.html" "photos/*.html" "events/*.html"

To preview locally:

    python3 -m http.server 8743

### Shared pieces

- The header nav is duplicated in every page. Change one, change them all (a small script is the sane way to do it).
- `nav.js` handles the dropdown menus, current-page highlighting, and assembles `mailto:` links at runtime so addresses aren't sitting in the page source for spam harvesters.
- `style.css` holds everything visual. Floated figures use `figure.alignleft` / `figure.alignright`, which only float at ≥900px wide.

## Publishing

Push to `main`. GitHub Pages builds and deploys automatically; `.nojekyll` keeps Jekyll out of the way.

## Notes

- Old WordPress URLs like `/our-team/` map to `team.html`, etc. Links between pages are relative, so the site also works when opened locally.
- Photos are capped at 2800px on the long edge, JPEG quality 85. Keep new photos in that range — the repo got large enough once to time out the Pages deploy.
- The Calving Validation data archive (`research/calving-validation-archive.html`) still links to `.hdf5` / metadata files on the old server. Move those to Zenodo or similar (GitHub rejects files over 100 MB) and update the links before retiring the old host.
