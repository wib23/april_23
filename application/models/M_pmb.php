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

    public function pendaftarPrestasi()
    {
        return $this->db->query('SELECT count(id_pendaftar) as jumlah, tingkat_prestasi
        FROM pendaftar_prestasi GROUP BY tingkat_prestasi')->result_array();
        // $this->db->select('tingkat_prestasi', 'COUNT(id_pendaftar) as jumlah');
        // $this->db->from ('pendaftar_prestasi');
        // $this->db->group_by('tingkat_prestasi');
        // $data = $this->db->get('pendaftar')->result_array();
        // return $data;
    }

    public function pendaftarJalurMasuk()
    {
        $this->db->select(['count(id_pendaftar) as jumlah', 'pendaftar.id_jalur', 'j.nama_jalur']);
        $this->db->join('jalur_masuk j', 'pendaftar.id_jalur = j.id_jalur');
        $this->db->group_by('pendaftar.id_jalur');
        $result = $this->db->get('pendaftar')->result_array();
        return $result;
    }

    public function listBank()
    {
        return $this->db->get('bank')->result_array();
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

    public function jumlahSPBank($jsp)
    {
        $result = 0;
        $this->db->where('id_bank', $jsp);
        $data = $this->db->get('bank')->result_array();
        if (!empty($data)) {
            $result = count($data);
        }
        return $result;
    }
}