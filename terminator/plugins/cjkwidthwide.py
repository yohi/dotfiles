#!/usr/bin/env python2
import terminatorlib.plugin as plugin
import terminatorlib.terminator as terminator

# AVAILABLE must contain a list of all the classes that you want exposed
AVAILABLE = ['CjkWidthWide']

class CjkWidthWide(plugin.Plugin):
    capabilities = []

    def __init__(self):
        plugin.Plugin.__init__(self)
        term = terminator.Terminator()
        for terminal in term.terminals:
            terminal.get_vte().set_cjk_ambiguous_width(2)
