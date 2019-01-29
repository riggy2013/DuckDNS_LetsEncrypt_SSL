# Duck_SSL

As DuckDNS supports DNS text record, we can apply Let's Encrypt SSL for it. Therefore, you will have a free SSL certificate for free DuckDNS domain. Here are the steps:

1. Apply DuckDNS account and create subdomain.

https://www.duckdns.org

I'll use subdomain example.duckdns.org below.

2. Install certbot.

https://certbot.eff.org

3. Use certbot to apply Let's Encrypt SSL certificate

Download duck_auth.sh and duck_remove.sh, add your duckdns.org token in.

    token=<DUCKDNS_TOKEN>

Then run command:

    sudo certbot certonly --manual --preferred-challenges dns --manual-auth-hook ./duck_auth.sh --manual-cleanup-hook ./duck_remove.sh -d example.duckdns.org
  
You will receive the below screen after several prompts:

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/example.duckdns.org/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/example.duckdns.org/privkey.pem
   Your cert will expire on 20##-##-##. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot
   again. To non-interactively renew *all* of your certificates, run
   "certbot renew"

4. Use crontab to renew the certificate.

As you can see above, Let's Encrypt SSL certificate will expire in three months. You are suggested to renew it before that. However, as you get the certificate in manual mode, simple "certbot renew" doesn't work; you still need the auth-hook.

    sudo certbot renew --manual --preferred-challenges dns --manual-auth-hook ./duck_auth.sh --manual-cleanup-hook ./duck_remove.sh

Currently certbot doesn't support renew particular certificate. The above command will renew all certificates in /etc/letsencrypt/live/. Of course you can run certbot certonly for particular certificate to renew it.

you can also use --renew-hook to restart your service after renewal. For example:

    sudo certbot renew --manual --preferred-challenges dns --manual-auth-hook ./duck_auth.sh --manual-cleanup-hook ./duck_remove.sh --renew-hook "service postfix reload".

You can save it as shell script or call it directly in crontab -e:

    0 0 1 */2 * (command here: renew or shell)

    
