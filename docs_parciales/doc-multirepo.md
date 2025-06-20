Permisos para clonar repositorios de manera local

```bash
git config --global protocol.file.allow always
```

### Error que mostraba sin ese comando
```bash
CHRISTIAN@LAPTOP-C7BQJMK9 MINGW64 ~/Desktop/PC3-DS-Grupo10/test-repo/test-multirepo/umbrella-repo (master)
$ git submodule add ../network-repo/ network-repo
Cloning into 'C:/Users/CHRISTIAN/Desktop/PC3-DS-Grupo10/test-repo/test-multirepo/umbrella-repo/network-repo'...
fatal: transport 'file' not allowed
fatal: clone of 'C:/Users/CHRISTIAN/Desktop/PC3-DS-Grupo10/test-repo/test-multirepo/network-repo' into submodule path 'C:/Users/CHRISTIAN/Desktop/PC3-DS-Grupo10/test-repo/test-multirepo/umbrella-repo/network-repo' failed
```

### Luego de ejecutar el comando
```bash
CHRISTIAN@LAPTOP-C7BQJMK9 MINGW64 ~/Desktop/PC3-DS-Grupo10/test-repo/test-multirepo/umbrella-repo (master)
$ git config --global protocol.file.allow always

CHRISTIAN@LAPTOP-C7BQJMK9 MINGW64 ~/Desktop/PC3-DS-Grupo10/test-repo/test-multirepo/umbrella-repo (master)
$ git submodule add ../network-repo network-repo
Cloning into 'C:/Users/CHRISTIAN/Desktop/PC3-DS-Grupo10/test-repo/test-multirepo/umbrella-repo/network-repo'...
done.
```

Con ese comando, nos da permisos para clonar repositorios locales, así que luego de ejecutar ese comando, recién podemos ejecutar el comando

```bash
# Agregar el repositorio network-repo como submodulo con el nombre network-repo
git submodule add ../network-repo network-repo

# Agregar el repositorio compute-repo como submodulo
git submodule add ../compute-repo compute-repo

# Agregar el repositorio storage-repo como submodulo

```

# Creamos la carpeta scripts
Con `mkdir scripts` creamos la carpeta scripts, luego ingresamos a la carpeta, y creamos el archivo bash para agregar un script que actualiza todo
```bash
# Ingresando a carpeta
cd scripts

# Creando archivo update_all.sh
touch update_all.sh
# Convertimos en archivo ejecutable
chmod +x update_all.sh
# Ahora podremos usarlo llamandolo con ./update_all.sh
```
El archivo update_all.sh actualizará los submódulos de la carpeta umbrella-repo a su último tag