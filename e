sudo apt update
sudo apt install qemu-kvm firefox openbox tigervnc-standalone-server
git clone https://github.com/novnc/noVNC
cd noVNC
sudo vncserver -SecurityType none -xstartup "openbox" -rfbport 5900
sudo ./utils/novnc_proxy --vnc 127.0.0.1:5900 --listen localhost:6080

sudo apt install konsole

cd Downloads
qemu-img create disk.img 10G
qemu-system-x86_64 --enable-kvm -m 4G -smp 2 -pflash /usr/share/OVMF/OVMF_CODE.fd -hdd disk.img -cdrom

diskpart
list disk
sel disk 0
conv gpt
cre par efi size=512
assign letter f
format fs=fat32 quick
cre par pri
assign letter c
format fs=ntfs quick
exit
dism /apply-image /imagefile:D:\Sources\install.wim /applydir:C:\ /index:6 /compactos
