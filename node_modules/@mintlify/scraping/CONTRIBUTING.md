# Running CLI Locally

Note - contributing requires `yarn` and it's recommended you install it as a global installation. If you don't have yarn installed already run `npm install -g yarn` in your terminal.

Run `yarn` or `yarn install` to install dependencies. Then, run `npm link` once to link to your local version of the CLI in the npm global namespace (`npm list -g`).

Build the CLI using `yarn build` or `yarn watch` to see your local changes reflected. Keep `yarn watch` running in a terminal for changes to be quickly and continuously reflected while developing.

To uninstall locally, run `npm uninstall @mintlify/scraping -g`.

# CLI Scraping

The CLI has many commands. This doc focuses on how we coded scraping websites.

## User Interface

There are two main commands:

`mintlify-scrape page [url]`

and

`mintlify-scrape section [url]`

Scraping a page downloads a single page’s content. Scraping a section goes through the navigation and scrapes each page. The code for downloading a page’s content is shared between the two commands.

Important files: `scraping/scrapePageCommands.ts`, `scraping/scrapeSectionAutomatically.ts`

We have `scrape-gitbook-page` and similar commands for debugging. Ignore them, they just call internal functions directly. You should not need to use them unless you are debugging issues with Detecting Frameworks.

## Overwriting

The user has to add a `--overwrite` flag if they want to overwrite their current files.

## Sections vs Websites

We call the command `scrape-section` instead of `scrape-website` because we cannot scrape pages not in the navigation of the URL first passed in. For example, ReadMe has API Reference and other sections accessible through a separate top-navigation which we do not parse. We only scrape the navigation on the left: [https://docs.readme.com/main/docs](https://docs.readme.com/main/docs)

## Detecting Frameworks

The commands look in the page HTML to detect what framework scraper to use. For example, all Docusaurus sites have a metatag with the word Docusaurus in it. Some times, the metatag even has the Docusaurus version.

Each framework’s scrapers live in `scraping/site-scrapers/`

We currently support:

- Docusaurus
- GitBook
- ReadMe
- Intercom

## Terminal Output

We print a line in the terminal for every file we write. `util.ts` has a createPage function that takes care of writing the file and logging.

We use a pencil emoji when we successfully write a file. Images get a picture emoji. Likewise, we print a X emoji when we find a file that already exists and the user has not enabled overwriting files. We use emojis so you can tell what the command is doing without reading each file path.

We also print the file paths when scraping sections so the user can easily copy paste them into mint.json. Note that pages the user already added in Mintlify are not included in the printed example. We do not generate mint.json completely, we are just giving a small example to help users starting from scratch.

```jsx
Add the following to your navigation in mint.json:

{
   "group": "Guides",
   "pages": ["page-we-scraped"]
}
```

# Navigation Scraping

Most sites use JavaScript to open navigation menus which do not automatically include the menu buttons in the HTML. We use Puppeteer to click every nested menu so the site adds the menu buttons to the HTML. For example the original site’s HTML:

```jsx
<div>
  <a id="my-nested-menu"></a>
</div>
```

can turn into this after opening the nested menu:

```jsx
<div>
  <a id="my-nested-menu" aria-expanded=true></a>
  <div>
     <a href="/page"></a>
     <a href="/other-page"></a>
  </div>
</div>
```

Ultimately, all section scrapers need to find an array of links to visit then call the scrape page function in a loop.

We use axios instead of Puppeteer if a site doesn’t hide links. Puppeteer is slow.

# Image File Locations

Images go in an `images/` folder because that’s what most users want. Scraping per section uses the same root-level images folder. Scraping per page downloads them to the current location. Thus, scraping a single page from a folder means the user always has to move the images themselves. That’s a trade-off we are comfortable with — trying to detect an existing images folder gets too complicated too fast.

# Cheerio

Cheerio is a library to scrape/handle the HTML after we have it in a string. Most of the work is using inspect-element to view a website and figure out where the content we want is, then writing the corresponding Cheerio code.

# HTML to MDX

We use an open-source library to convert HTML to Markdown: https://github.com/crosstype/node-html-markdown

The `util.ts` createPage function assembles the MDX metadata, we just need to return an object of the form `{ title, description, content }` from each page scraper.

## Parsing Issues

Parsing struggles when documentation websites are using non-standard HTML. For example, code blocks are supposed to use. `<pre><code></code></pre>` but GitBook just uses divs.

We can write custom translators for the library that determine how we parse certain objects.

In some cases, we will want custom translators even if parsing succeeds. For example, ReadMe callouts are using quote syntax

```jsx
> 💡
> Callout text
>
```

When we want to convert them to:

```jsx
<Tip>Callout text</Tip>
```

## Regex

You can use regex to make small changes where translators are overkill or there’s no obvious component to modify. For example, here’s the end of `scrapeDocusaurusPage.ts`:
