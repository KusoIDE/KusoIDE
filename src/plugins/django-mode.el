(setq runserver-buffer "*Runserver*")
(setq runserver-process (start-process-shell-command "runserver-process" runserver-buffer "python manage.py runserver --noreload"))