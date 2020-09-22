import datetime

import functools

from seesaw.externalprocess import ExternalProcess
from seesaw.pipeline import Pipeline
from seesaw.project import Project
from seesaw.task import Task, LimitConcurrent
from tornado.ioloop import IOLoop

project = Project(
    title='Warrior Extras Installer',
    project_html='''
        <img class="project-logo" alt=""
            src="https://tracker.archiveteam.org/~chfoo/image/200px-Applications-system.svg.png"
            height="50" />
        <h2>Warrior Extras Installer</h2>
        <p>Select this project, when required, to install extra software components required by other projects.</p>
        '''
)


class WarningTask(Task):
    def __init__(self):
        Task.__init__(self, 'WarningTask')

    def enqueue(self, item):
        self.start_item(item)
        item.may_be_canceled = True
        item.log_output(
            'This project will install extra software components required by other projects.')
        item.log_output('It is intended to be run within a Warrior VM appliance or Warrior Docker container. '
                        'Press CTRL+C to cancel.')
        item.log_output('Update will continue in 5 seconds...')

        IOLoop.instance().add_timeout(
            datetime.timedelta(seconds=10),
            functools.partial(self._finish, item)
        )

    def _finish(self, item):
        item.may_be_canceled = False
        self.complete_item(item)


class IdleTask(Task):
    def __init__(self):
        Task.__init__(self, 'IdleTask')

    def enqueue(self, item):
        self.start_item(item)
        item.may_be_canceled = True
        item.log_output('Pausing for 60 seconds...')

        IOLoop.instance().add_timeout(
            datetime.timedelta(seconds=60),
            functools.partial(self._finish, item)
        )

    def _finish(self, item):
        item.may_be_canceled = False
        self.complete_item(item)


pipeline = Pipeline(
    WarningTask(),
    LimitConcurrent(1, ExternalProcess('Install', ['./install.sh'])),
    IdleTask(),
)
