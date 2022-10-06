@echo off
echo New DNS pointer needed, edit your DNS

PAUSE

rendom /list

echo Edit "DomainList" files generated with your new domain

PAUSE

rendom /showforest
rendom /upload
rendom /prepare
rendom /execute

PAUSE

