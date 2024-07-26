#!/bin/bash

#pasamos los parametros a modificar, se ejecuta como user zimbra

value=350
echo "Iniciando el script de customizacion de Zimbra"

#aumentamos los hilos de indexado de Zimbra
zmlocalconfig -e zimbra_index_threads=$value
echo "Hilos para indexado aunmentado a $value"
#aumentamos los hilos para el indice de espera de zimbra
zmlocalconfig -e zimbra_mailbox_lock_max_waiting_threads=$value
echo "Hilos para tiempo de espera en busqueda de correo aumentado a $value"
#aumentamos la cantidad de hilos para reindexado de Zimbra
zmlocalconfig -e zimbra_reindex_threads=$value
echo "Hilos para reindexado de zimbra aumentado a $value"
#ajustamos las variables globales del servidor
echo "Ajustando variables globales del Zimbra ...... "
zmprov ms `zmhostname` zimbraHttpNumThreads $value
zmprov ms `zmhostname` zimbraLmtpNumThreads $value
echo "..... Hecho"
#reiniciamos el zimbra para aplicar los cambios
echo "Reiniciando el Zimbra para aplicar los cambios"
zmcontrol restart

#validamos el estado de los servicios de zimbra 
zmcontrol status

echo "Proceso finalizado con exito ....."
