rsync -av /typo3/typo3_src-$1*/ /var/www/html/typo3_src

if [ ! -d /var/www/html/typo3 ]
    then
	cd /var/www/html && \
    ln -s typo3_src/index.php && \
    ln -s typo3_src/typo3 && \
    ln -s typo3_src/_.htaccess .htaccess && \
    touch FIRST_INSTALL && \
    chown -R www-data /var/www/html
fi

apache2-foreground