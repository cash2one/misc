KVDict
======

Ӧ�ñ���
--------
��ҪΪ�˽��python�ʵ�ռ���ڴ���������
������һ�¼������::
    * ��һ���ı����յ�һ��Ϊkey������Ϊvalue�ķ�ʽ�����ڴ档
    * ͬ�����������ļ����������ڴ棬ֻ�ǽ���һ������

ʹ�÷���
--------
���Բο�kvdict.py��ʹ�÷�������Ҫ�м��������

    �����ʵ�:
       import kvdict
       # ����һ���ڴ�ʵ�
       dct = kvdict.KVDict()
       # ����һ���ļ������ʵ�
       idx_dct = kvdict.FileIndexKVDict()

    ��ȡ�ļ�
        dct.load(filename)
        dct.load([filenameA, filenameB, filenameC])
        idx_dct.load(filename)
        idx_dct.load([filenameA, filenameB, filenameC])

    ��ѯ
        ret = dct.find(key)
        # or
        # ret = idx_dct.find(key)
        if ret is None:
            # not found.
            pass
        else:
            # found.

    ���л��ڴ�ʵ䣨�����´ζ�ȡ��
        dct.dump_bin(output_filename)
        dct.load_bin(input_filename)

