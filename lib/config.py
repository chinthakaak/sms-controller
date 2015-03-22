__author__ = 'ka40215'
import ConfigParser

# Create default configurations
config=ConfigParser.RawConfigParser()
config.add_section('smsmod')
config.set('smsmod','smsdrc','/data/install/gammu-smsd/smsdrc')
config.set('smsmod','phonenumber','077239126')
config.set('smsmod','smsretries',2)

with open('smsmod.cfg','wb') as configfile:
    config.write(configfile)