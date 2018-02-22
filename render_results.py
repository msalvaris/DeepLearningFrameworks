from mako.template import Template


if __name__=='__main__':
    mytemplate = Template(filename='readme.template')
    print(mytemplate.render())
