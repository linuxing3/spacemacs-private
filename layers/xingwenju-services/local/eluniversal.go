package main

import (
	"encoding/json"
	"fmt"
	"log"
	"strings"

	"github.com/PuerkitoBio/goquery"
	"github.com/gocolly/colly"
)

// News stores information about a coursera course
type News struct {
	Title string
	URL   string
	text  string
}

func main() {
	// Instantiate default collector
	c := colly.NewCollector()

	// Visit only domains: coursera.org, www.coursera.org
	c.AllowedDomains = []string{"eluniversal.com", "www.eluniversal.com"}

	// Cache responses to prevent multiple download of pages
	// even if the collector is restarted
	c.CacheDir = "./eluniversal_cache"

	// Create another collector to scrape course details
	detailCollector := c.Clone()

	allNews := make([]News, 0, 200)

	// Before making a request print "Visiting ..."
	c.OnRequest(func(r *colly.Request) {
		log.Println("visiting", r.URL.String())
	})

	// On every a HTML element which has name attribute call callback
	c.OnHTML(`a`, func(e *colly.HTMLElement) {
		// Activate detailCollector if the link contains "coursera.org/learn"
		newsURL := e.Request.AbsoluteURL(e.Attr("href"))
		if strings.Index(newsURL, "eluniversal.com/noticias") != -1 {
			detailCollector.Visit(newsURL)
		}
	})

	// Extract details of the course
	detailCollector.OnHTML(`h2[class=title]`, func(e *colly.HTMLElement) {

		log.Println("News found", e.Request.URL)

		title := e.Text
		if title == "" {
			log.Println("No title found", e.Request.URL)
		}

		news := News{
			Title: title,
			URL:   e.Request.URL.String(),
		}
		log.Println("findings text")
		// Iterate over rows of the table which contains different information
		// about the course
		e.DOM.Find("div").Each(func(_ int, s *goquery.Selection) {
			log.Println("p found")
			// news.text = s.Find("p").Text()
		})

		allNews = append(allNews, news)
	})

	// Start scraping on http://coursera.com/browse
	c.Visit("http://eluniversal.com")

	// Convert results to JSON data if the scraping job has finished
	jsonData, err := json.MarshalIndent(allNews, "", "  ")
	if err != nil {
		panic(err)
	}

	// Dump json to the standard output (can be redirected to a file)
	fmt.Println(string(jsonData))
}
