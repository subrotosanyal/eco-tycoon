from abc import ABC, abstractmethod
from dataclasses import dataclass
from typing import Any

@dataclass
class CommandState:
    name: str
    label: str
    icon: str
    color: str
    enabled: bool = True

class Command(ABC):
    def __init__(self, state: CommandState):
        self._state = state
    
    @property
    def state(self) -> CommandState:
        return self._state
    
    @abstractmethod
    def execute(self) -> Any:
        pass

    def enable(self) -> None:
        self._state.enabled = True
    
    def disable(self) -> None:
        self._state.enabled = False
