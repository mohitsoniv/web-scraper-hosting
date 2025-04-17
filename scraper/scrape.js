const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

(async () => {
    const url = process.env.SCRAPE_URL;

    if (!url) {
        console.error('Please provide a URL via the SCRAPE_URL environment variable.');
        process.exit(1);
    }

    const browser = await puppeteer.launch({
        headless: true,
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    });

    const page = await browser.newPage();
    await page.goto(url);

    const title = await page.title();
    const heading = await page.$eval('h1', el => el.innerText);

    const scrapedData = {
        title: title,
        heading: heading
    };

    // Ensure the output directory exists
    const outputDir = '/output';
    if (!fs.existsSync(outputDir)) {
        fs.mkdirSync(outputDir, { recursive: true });
    }

    // Write the scraped data to the output directory
    const outputPath = path.join(outputDir, 'scraped_data.json');
    fs.writeFileSync(outputPath, JSON.stringify(scrapedData, null, 2));

    console.log(`Scraped data saved to ${outputPath}`);

    await browser.close();
})();
