package com.ruoyi.common.utils.file;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import org.springframework.web.multipart.MultipartFile;

/**
 * In-memory MultipartFile for generated images.
 */
public class ByteArrayMultipartFile implements MultipartFile
{
    private final String name;
    private final String originalFilename;
    private final String contentType;
    private final byte[] content;

    public ByteArrayMultipartFile(String name, String originalFilename, String contentType, byte[] content)
    {
        this.name = name;
        this.originalFilename = originalFilename;
        this.contentType = contentType;
        this.content = content == null ? new byte[0] : content;
    }

    @Override
    public String getName()
    {
        return name;
    }

    @Override
    public String getOriginalFilename()
    {
        return originalFilename;
    }

    @Override
    public String getContentType()
    {
        return contentType;
    }

    @Override
    public boolean isEmpty()
    {
        return content.length == 0;
    }

    @Override
    public long getSize()
    {
        return content.length;
    }

    @Override
    public byte[] getBytes()
    {
        return content;
    }

    @Override
    public InputStream getInputStream()
    {
        return new ByteArrayInputStream(content);
    }

    @Override
    public void transferTo(File dest) throws IOException, IllegalStateException
    {
        FileOutputStream out = new FileOutputStream(dest);
        try
        {
            out.write(content);
        }
        finally
        {
            out.close();
        }
    }
}
