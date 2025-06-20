import subprocess

def test_simular_drift_script():
    bash_path = "bash"

    result = subprocess.run(
        [bash_path, "scripts/simular_drift.sh"],
        shell=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )

    stdout = result.stdout.decode('utf-8', errors='replace')
    stderr = result.stderr.decode('utf-8', errors='replace')

    print("STDOUT:", stdout)
    print("STDERR:", stderr)

    assert result.returncode == 0, f"❌ Error al ejecutar el script:\n{stderr}"
    assert "✅ Simulación de drift completada en todos los submódulos." in stdout
