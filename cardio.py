"""cardio -- example datacard processing

A simple module to facilitate processing datacards
during a snakemake workflow.

Attributes:
    Card (class): wrapper class to hold data from
        loaded datacard

Todo:
    - [] Card
      - [] Create
      - [] Dump files
      - [] Dump commands
    - [x] Load card
    - [x] Create card
"""
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Dict
import yaml


@dataclass
class Card:
    """
    A simple wrapper class to hold data loaded
    from an input data card

    Attributes:
        data: data from the datacard

    Interface:
        dump_files:    dump filepaths to a list
        dump_commands: dump commands to bash scripts
    """
    data: Dict[str, Any] = field(default_factory=dict)

    def __getitem__(self, key: str) -> Any:
        """
        Get card data at 'key'.
        """
        return self.data[key]

    def __init__(self, path: str = None):
        """
        Initialize with a card at `path`.

        Arguments:
            path: path to card
        """
        if path is not None:
            with open(Path(path), 'r') as card:
                data = yaml.safe_load(card)

    def create(self, name: str) -> None:
        """
        Create a datacard at 'name' and dump
        data to it.

        Attributes:
            name: path to datacard
        """a
        # TODO expand to tabulate files
        # in output location
        with open(name, 'w') as card:
            yaml.dump(self.data, card)

    def dump_files(self, name: str, protocol: str = None, in_shell: bool = False) -> None:
        """
        Dump files to a list at 'name'. If
        protocol is 'rucio', will query file
        catalog based on `identifier`.
        """
        # TODO
        return

    def dump_commands(self, tag: str = None) -> None:
        """
        Dump commands for each rule to shell
        scripts. Will append 'tag' to name
        if not None.
        """
        # TODO
        return


def load_card(path: str) -> Card:
    """
    Load a datacard at 'path'.

    Arguments:
        path: path to the card to load
    """
    return Card(path)


def make_card(path: str, temp: str) -> Card:
    """
    Make a datacard at 'path' based
    on template at 'temp'.

    Arguments:
       path: path to card to make
       temp: path to template card
    """
    output = Card(temp)
    output.create(path)
    return Card(path)
