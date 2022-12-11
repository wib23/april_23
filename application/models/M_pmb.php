<?php
class M_pmb extends CI_Model
{
    public function listPendaftar()
    {
        return $this->db->get('pendaftar')->result_array();
    }

    public function listProdi()
    {
        return $this->db->get('prodi')->result_array();
    }

    public function listPendaftarPrestasi()
    {
        return $this->db->get('pendaftar_prestasi')->result_array();
    }

    public function listPrestasi()
    {
        return $this->db->get('pendaftar_prestasi')->result_array();
    }

    public function listJalurMasuk()
    {
        return $this->db->get('jalur_masuk')->result_array();
    }

    public function listBank()
    {
        return $this->db->get('bank')->result_array();
    }

    public function jumlahPendaftarProdi1($idProdi)
    {
        $result = 0;
        $this->db->where('id_prodi1', $idProdi);
        $data = $this->db->get('pendaftar')->result_array();
        if (!empty($data)) {
            $result = count($data);
        }
        return $result;
    }

    public function jumlahPendaftarProdi2($idProdi)
    {
        $result = 0;
        $this->db->where('id_prodi2', $idProdi);
        $data = $this->db->get('pendaftar')->result_array();
        if (!empty($data)) {
            $result = count($data);
        }
        return $result;
    }

    public function jumlahPendaftarPrestasi($tingkat_prestasi)
    {
        $result = 0;
        $this->db->where('tingkat_prestasi', $tingkat_prestasi);
        $data = $this->db->get('pendaftar_prestasi')->result_array();
        if (!empty($data)) {
            $result = count($data);
        }
        return $result;
    }

    public function jumlahPendaftarJalurMasuk($id_jalur)
    {
        $result = 0;
        $this->db->where('id_jalur', $id_jalur);
        $data = $this->db->get('pendaftar')->result_array();
        if (!empty($data)) {
            $result = count($data);
        }
        return $result;
    }

    public function jumlahPendapatanBank($idj)
    {
        $result = 0;
        $this->db->where('id_bank', $idj);
        $data = $this->db->get('bank')->result_array();
        if (!empty($data)) {
            $result = count($data);
        }
        return $result;
    }
}