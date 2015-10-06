--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll
import           Hakyll.Core.Configuration

config :: Configuration
config = defaultConfiguration
        { deployCommand = "rsync -avz -e ssh ./_site/ haskellbook.com:/var/www/haskellbook.com/ && rsync -avz -e ssh ./google99d5b04124accf30.html haskellbook.com:/var/www/haskellbook.com/google99d5b04124accf30.html"}

contentPage title = do
  route idRoute
  compile $ do
    let indexCtx =
          constField "title" title `mappend` defaultContext

    getResourceBody
      >>= applyAsTemplate indexCtx
      >>= loadAndApplyTemplate "templates/default.html" indexCtx
      >>= relativizeUrls

--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith config $ do
    match "js/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "js/vendor/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "index.html" (contentPage "Home")

    match "support.html" (contentPage "Support")

    match "progress.html" (contentPage "Progress")

    match "feedback.html" (contentPage "Feedback")

    match "authors.html" (contentPage "Authors")

    match "faq.html" (contentPage "FAQ")

    match "tools.html" (contentPage "Tools")

    match "templates/*" $ compile templateCompiler
