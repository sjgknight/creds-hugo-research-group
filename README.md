Template for group website from Wowchemy, with some minor tweaks as below.

## My notes for files

---
#main title is required
title: 

#You can also include a subtitle
subtitle: 

#If you want the summary to be something other than the first paragraph, put one in here. 
summary:

#show the date for the page, set show_date to false to hide this. Date is in form 2021-08-03 YYYY-mm-dd
date: 

#true by default
show_date:

#wont show in lists if set to true
draft: false

#can be used to highlight content in various places
featured: true

# Featured image
# To use, place an image named `featured.jpg/png` in your page's folder.
# Placement options: 1 = Full column width, 2 = Out-set, 3 = Screen-width
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
# Set `preview_only` to `true` to just use the image for thumbnails.
image:
  filename: featured
  placement: 1
  focal_point: Smart
  preview_only: false
  caption: "caption here"
  alt_text: "Concise description here" 


#if the page is a link to another page use this (generally use the links below instead)
external_link: 

#use this structure to add call to action links at the top of the page. No more than 2 or it looks poor
links:
  - icon_pack: fas
    icon: arrow-alt-circle-left
    name: View all our research
    url: '/research'
  - icon_pack: fas
    icon: eye
    name: More on project site
    url: ''

#add authors itll auto link to ones with profiles. Use comma separated in squares like this
#you can also add partner organisations here (give them that role in the author page)
#and UTS-collaborators external-collaborators industry-collaborators (same thing)
authors: ["Kirsty Kitto"]

#add categories from options: news, illustrations, learn, resources, methods
#to create a method page create a tag first and then add the category method to the tag
categories: 
  - 

#add tags you can use like categories or like authors. Tags might cover
#technology, including: learning-analytics, mobile-technologies, 
#country or region, including: 
#sector, including: HE, schools, industry, GLAM, lifelong-learning, online-communities
#pedagogy and practice, including: sociocultural-theory, dialogic-learning, CSCL, active-learning, reflection
#content, including: recognition, funding, 
#theme which are: Change-Design, Literacies, Data-literacy, Teachers
tags: [""]

---

Put content here


Sections: News (posts), Projects, Authors (inc partners), Publications, Events

Pages: Research (shows projects), People (shows authors pages), Partners (shows authors pages), 

Refer to https://wowchemy.com/docs/content/writing-markdown-latex/ for more things.

> blockquotes like this

cta buttons like this:
{{< cta cta_text="Visit the Teacher Professional Learning Networks site" cta_link="https://sites.google.com/site/educatorplns/" cta_new_tab="true" >}}


## Cross ref things
You can refer to other pages like this, views are 4 is an APA citation, 3 is a card, 1 and 2 are listy
YOU MUST NOT INCLUDE TRAILING SLASH IN ANY LINKS

{{< cite page="/publication/preprint" view="4" >}}


## Make spoilers
To create a spoiler (expandable) use

{{< spoiler text="Click to read more" >}}
and close
{{< /spoiler >}}

## Embed some stuff 

{{< youtube WXxp3saPeXQ >}}
{{< vimeo 146022717 >}}

{{< tweet 666616452582129664 >}}

{{< gdocs src="https://docs.google.com/..." >}} (but needs to be published)

### For embedding images (not just in the header)

There's a markdown way, and there's an inelegant (but, let's you do useful things) way, e.g of the latter:
<div style= "float:right;margin:5px;width:50%;">{{< figure src="analytics.jpg" caption="Modeling change, Photo by <a href='https://unsplash.com/@edhoradic?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText'>Edho Pratama</a> on <a href='https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText'>Unsplash</a>" numbered="false" alt="Search result image for 'analytics', by Edho Pratama on Unsplash" >}}</div>

### To insert tables

Check out one of the markdown table generators, or use the gui rstudio approach

## If you have a HTML page (e.g. from the conversation) you want to embed
1. create an index.md page as usual, with yaml header per above
2. in the index.md content use {{< include-md "body.md" >}}
3. in body.md put an empty header ( ---  and close --- ), and whatever's between <body> tags in html


## To make links
[I'm an external link](https://www.google.com)
[A post]({{< relref "/post/my-page-name" >}})
[A publication]({{< relref "/publication/my-page-name" >}})
[A project]({{< relref "/project/my-page-name" >}})
[A relative link from one post to another post]({{< relref "../my-page-name" >}})
[Scroll down to a page section with heading *Hi*](#hi)

### and for a file you might put it in /static/uploads/
{{% staticref "uploads/cv.pdf" "newtab" %}}Download my CV{{% /staticref %}}




## References
Used another great tool, wowchemy publication tool to create publication pages from bibtex; may need periodic updating (or connecting to a feed) https://github.com/wowchemy/hugo-academic-cli 

I obtained the bibtex from publish or perish (via google scholar), and did some minor editing in Zotero before exporting. BUT this is flawed, scholar only lets you grab the first x authors, so many pubs have ... as an author...these need fixing at some point

## Link gardens and back links
I'm interested in drawing on ideas of digital gardens or link gardens, in which rather than organising by date, people navigate through starting at different points and going down different paths through connected content.  Tags and categories can do that to some degree, but it tends to always be sequential. An obvious use case in academia is wanting to show links between people <-> projects <-> publications <-> news <-> methods, etc. 

To do this I made some edits from (note, if the directory structure is as mine/wowchemy and uses index.md within a named directory per-post, you need to change BaseFileName to ContentBaseName in the backlinks partial)

* https://git.sehn.dev/linozen/wowchemy-hugo-modules/src/commit/b1acd15a2ef6958c2aefd806d9f7cd6f212565a7/wowchemy/layouts/partials/backlinks.html 

Other places that have implemented some form of backlink approach in hugo are:
* https://github.com/kausalflow/connectome/tree/master/layouts/partials (see also https://hugo-connectome.kausalflow.com/graph/ )
*  https://gabrielleearnshaw.medium.com/implementing-backlinks-in-a-hugo-website-e548d3d8f0e0 
* and https://seds.nl/notes/export_org_roam_backlinks_with_gohugo/ (despite the url it isn't roam export, it's within hugo)
* @apreshill also has an "on this page" which shows the headings for a page, which I assume could be used to show the links https://github.com/rbind/apreshill/search?q=%22on+this+page%22&type= 

In Jekyll see :
* https://digital-garden-jekyll-template.netlify.app/your-first-note
* https://github.com/maximevaillancourt/digital-garden-jekyll-template/network/members 
* https://manunamz.github.io/jekyll-bonsai/

Roam is a common note tool for this kind of approach
* https://nesslabs.com/roam-research 


## Wowchemy's Research Group Template for [Hugo](https://github.com/gohugoio/hugo)

The **Research Group Template** empowers your research group to easily create a beautiful website with a stunning homepage, news, academic publications, events, team profiles, and a contact form.

[Check out the latest demo](https://research-group.netlify.app/) of what you'll get in less than 5 minutes, or [view the showcase](https://wowchemy.com/user-stories/).

_[**Wowchemy**](https://wowchemy.com) makes it easy to create a beautiful website for free. Edit your site in Markdown, Jupyter, or RStudio (via Blogdown), generate it with Hugo, and deploy with GitHub or Netlify. Customize anything on your site with widgets, themes, and language packs._

- 👉 [**Get Started**](https://wowchemy.com/templates/)
- 📚 [View the **documentation**](https://wowchemy.com/docs/)
- 💬 [Chat with the **Wowchemy community**](https://discord.gg/z8wNYzb) or [**Hugo community**](https://discourse.gohugo.io)
- 🐦 Twitter: [@wowchemy](https://twitter.com/wowchemy) [@GeorgeCushen](https://twitter.com/GeorgeCushen) [#MadeWithWowchemy](https://twitter.com/search?q=(%23MadeWithWowchemy%20OR%20%23MadeWithAcademic)&src=typed_query)
- 💡 [Request a **feature** or report a **bug** for _Wowchemy_](https://github.com/wowchemy/wowchemy-hugo-modules/issues)
- ⬆️ **Updating Wowchemy?** View the [Update Guide](https://wowchemy.com/docs/update/) and [Release Notes](https://github.com/wowchemy/wowchemy-hugo-modules/releases)

### Crowd-funded open-source software

To help us develop this template and software sustainably under the MIT license, we ask all individuals and businesses that use it to help support its ongoing maintenance and development via sponsorship.

#### [❤️ Click here to unlock rewards with sponsorship](https://wowchemy.com/sponsor/)

### Ecosystem

* **[Hugo Academic CLI](https://github.com/wowchemy/hugo-academic-cli/):** Automatically import publications from BibTeX

[![Screenshot](./preview.png)](https://wowchemy.com/templates/)
