import { chromium } from 'playwright';

(async () => {
  const browser = await chromium.launch({ headless: true, args: ['--no-sandbox'] });
  const page = await browser.newPage();

  // Abrimos la búsqueda de empleos
  await page.goto('https://www.linkedin.com/jobs/search/?keywords=software%20developer&location=Colombia', { waitUntil: 'networkidle' });

  await page.waitForSelector('.jobs-search__results-list li', { timeout: 15000 });

  // Extraemos los resultados
  const jobs = await page.$$eval('.jobs-search__results-list li', els =>
    els.map(el => ({
      title: el.querySelector('h3')?.innerText.trim(),
      company: el.querySelector('.base-search-card__subtitle')?.innerText.trim(),
      location: el.querySelector('.job-search-card__location')?.innerText.trim(),
      link: el.querySelector('a.base-card__full-link')?.href
    }))
  );

  console.log(JSON.stringify(jobs, null, 2));
  await browser.close();
})();
